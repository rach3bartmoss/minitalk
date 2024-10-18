/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: dopereir <dopereir@student.42porto.com>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/10/17 21:40:08 by dopereir          #+#    #+#             */
/*   Updated: 2024/10/18 22:26:57 by dopereir         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>
#include <signal.h>
#include <sys/types.h>
//#include <sys/siginfo.h>
#include <stdio.h>

#include "minitalk.h"

void	signal_handler(int signum, siginfo_t *info, void *context)
{
	static t_client_info	client_info = {0, 0, 0};

	(void)context;
	if (client_info.pid != info->si_pid)
	{
		client_info.bit_count = 0;
		client_info.current_char = 0;
		client_info.pid = info->si_pid;
	}
	client_info.current_char = (client_info.current_char << 1)
		| (signum == SIGUSR2);
	client_info.bit_count++;
	if (client_info.bit_count == 8)
	{
		write(1, &client_info.current_char, 1);
		if (client_info.current_char == '\0')
			kill(client_info.pid, SIGUSR2);
		client_info.bit_count = 0;
		client_info.current_char = 0;
	}
	if (kill(client_info.pid, SIGUSR1) == -1)
	{
		write(1, "Error sending acknowledgment signal\n", 37);
		exit(0);
	}
}

int	main(void)
{
	struct sigaction	sa;

	sa.sa_sigaction = signal_handler;
	sa.sa_flags = SA_SIGINFO;
	sigemptyset(&sa.sa_mask);
	if (sigaction(SIGUSR1, &sa, NULL) == -1
		|| sigaction(SIGUSR2, &sa, NULL) == -1)
	{
		write(1, "Error setting up signal handler\n", 33);
		return (EXIT_FAILURE);
	}
	printf("Server PID: %d\n", getpid());
	while (1)
		pause();
	return (0);
}
