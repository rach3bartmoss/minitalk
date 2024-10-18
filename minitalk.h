/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   minitalk.h                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: dopereir <dopereir@student.42porto.com>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/10/18 21:40:10 by dopereir          #+#    #+#             */
/*   Updated: 2024/10/18 22:30:15 by dopereir         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef MINITALK_H
# define MINITALK_H

# include <signal.h>
# include <unistd.h>
# include <stdlib.h>
# include <stdio.h>

typedef struct	s_client_info
{
	pid_t			pid;
	int				bit_count;
	unsigned char	current_char;
}	t_client_info;

void	send_bit(int pid, int bit);
void	send_char(int pid, unsigned char c);
void	send_string(int pid, const char *str);

void	signal_handler(int signum, siginfo_t *info, void *context);

#endif
