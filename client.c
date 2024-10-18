/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: dopereir <dopereir@student.42porto.com>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/10/18 22:23:02 by dopereir          #+#    #+#             */
/*   Updated: 2024/10/18 22:28:51 by dopereir         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <signal.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>

volatile sig_atomic_t	g_bit_set = 0;

void	ack_handler(int signum)
{
	if (signum == SIGUSR2)
		write(1, "\nMessage fully delivered at server\n", 36);
	g_bit_set = 1;
}

void	send_bit(int pid, int bit)
{
	int	signal;

	if (bit == 1)
		signal = SIGUSR2;
	else
		signal = SIGUSR1;
	if (kill(pid, signal) == -1)
	{
		perror("Error sending signal");
		exit(EXIT_FAILURE);
	}
	while (!g_bit_set)
		usleep(100);
	g_bit_set = 0;
}

void	send_char(int pid, unsigned char c)
{
	int	i;

	i = 7;
	while (i >= 0)
	{
		send_bit(pid, (c >> i) & 1);
		i--;
	}
}

void	send_string(int pid, const char *str)
{
	while (*str)
		send_char(pid, *str++);
	send_char(pid, '\0');
}

int	main(int ac, char **av)
{
	int					pid;
	struct sigaction	sa;

	if (ac != 3)
	{
		write(1, "Usage: %s <server_pid> <message>\n", 34);
		return (0);
	}
	pid = atoi(av[1]);
	sa.sa_sigaction = (void *)ack_handler;
	sigaction (SIGUSR2, &sa, NULL);
	sigaction (SIGUSR1, &sa, NULL);
	sa.sa_flags = SA_SIGINFO;
	sigemptyset(&sa.sa_mask);
	send_string(pid, av[2]);
	return (0);
}
