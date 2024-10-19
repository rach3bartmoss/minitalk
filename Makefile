# Variables
CC = gcc
CFLAGS = -Wall -Wextra -Werror
PRINTF_DIR = ./ft_printf
PRINTF = $(PRINTF_DIR)/libftprintf.a
INCLUDES = -I. -I$(PRINTF_DIR)
NAME_CLIENT = client
NAME_SERVER = server

# Colors
YELLOW = \033[1;33m
RED = \033[1;31m
BLUE = \033[1;34m
GREEN = \033[1;32m
RESET = \033[0m

# Source files
SRCS_CLIENT = client.c
SRCS_SERVER = server.c

# Object files
OBJS_CLIENT = $(SRCS_CLIENT:.c=.o)
OBJS_SERVER = $(SRCS_SERVER:.c=.o)

# Targets
all: init $(PRINTF) $(NAME_CLIENT) $(NAME_SERVER)

# Custom init with ASCII art
init:
	@echo "$(YELLOW)"
	@echo "# [ASCII art removed for brevity]"
	@echo "$(RESET)"
	@sleep 1

# Build the ft_printf library silently
$(PRINTF):
	@$(MAKE) -C $(PRINTF_DIR) --silent

# Compile the client
$(NAME_CLIENT): $(OBJS_CLIENT) $(PRINTF)
	@echo "$(BLUE)Compiling client...$(RESET)"
	$(CC) $(CFLAGS) $(OBJS_CLIENT) $(PRINTF) $(INCLUDES) -o $(NAME_CLIENT)
	@echo "$(GREEN)Client compiled successfully!$(RESET)"

# Compile the server
$(NAME_SERVER): $(OBJS_SERVER) $(PRINTF)
	@echo "$(BLUE)Compiling server...$(RESET)"
	$(CC) $(CFLAGS) $(OBJS_SERVER) $(PRINTF) $(INCLUDES) -o $(NAME_SERVER)
	@echo "$(GREEN)Server compiled successfully!$(RESET)"

# Compile .c files to .o files
%.o: %.c minitalk.h
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

# Clean object files
clean:
	@$(MAKE) -C $(PRINTF_DIR) clean --silent
	@echo "$(RED)Cleaning object files...$(RESET)"
	@rm -f $(OBJS_CLIENT) $(OBJS_SERVER)
	@echo "$(GREEN)Object files cleaned!$(RESET)"

# Remove compiled binaries and libraries
fclean: clean
	@$(MAKE) -C $(PRINTF_DIR) fclean --silent
	@echo "$(RED)Removing binaries...$(RESET)"
	@rm -f $(NAME_CLIENT) $(NAME_SERVER)
	@echo "$(GREEN)Binaries removed!$(RESET)"

# Rebuild everything
re: fclean all

.PHONY: all clean fclean re init