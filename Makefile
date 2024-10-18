# Variables
CC = gcc
CFLAGS = -Wall -Wextra -Werror
LIBFT_DIR = ./libft
PRINTF_DIR = ./ft_printf
LIBFT = $(LIBFT_DIR)/libft.a
PRINTF = $(PRINTF_DIR)/libftprintf.a
INCLUDES = -I$(LIBFT_DIR) -I$(PRINTF_DIR)
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

all: init $(LIBFT) $(PRINTF) $(NAME_CLIENT) $(NAME_SERVER)

# Custom init with new mask from file
init:
	@echo "$(YELLOW)                                              "
	@echo "                   ..::..                    "
	@echo "               .:::::::::::::                "
	@echo "             ::::::::::::::::::.             "
	@echo "           ::::::::::::-=-:::::::.           "
	@echo "          ::::::::-%*********%-:::.          "
	@echo "        .:::::::#@*++++++*%@@@@%-:::         "
	@echo "       .::::::+%%++++++*%@@%#*+*#*:::        "
	@echo "      .::::::#@#++++++*@@@#+++++++*:::       "
	@echo "      ::::::%@#++++++*@@@#+++++++++-::.      "
	@echo "     .:::::@@%+++++++@@@@++++++++++%:::.     "
	@echo "    .:::::=%@*++++++%@@@%+++++++++++=:::     "
	@echo "    ::::::*+@+++++++@@#+++++++++++++#:::.    "
	@echo "   .:::::=++#+++++++#*+++++++++++*++*::::    "
	@echo "   ::::::#+++++++++++++++++++*%%%%@+++:::.   "
	@echo "   :::::-%++++++++++++++++*%%%%@@%%+++::::   "
	@echo "  .:::::=@%#**+++++++*#%%@%%%%@@@@@+#=::::   "
	@echo "  ::::::=@@@@@@@@@@@@@@@%%%%%%%@@@#+#+::::   "
	@echo "  ::::::=@@@@@@@@@@@@@@%%%%%%%%%%%*+*+::::.  "
	@echo "  ::::::=%@@@@@@@@@@@#%%%%%%%%%%%*+**+:::::  "
	@echo "  ::::::=#%@@@@@@@@@#%*%%%%%@%%%#++#+=:::::  "
	@echo "  ::::::-#%%%@@@@@@%+#%@@@@@%%%#++**++:::::  "
	@echo "  :::::::#%%%%%%%%%%%*@@@@@@%%#++**++-:::::  "
	@echo "  :::::::%%%%%%%%%%%%%@@@@@@%#++**++#::::::  "
	@echo "  :::::::@#%%%%%%%%%@%@@@@@@#++**+++=:::::.  "
	@echo "  :::::::**%%%%%%%%@*@@@@@@#++*#+++*-:::::   "
	@echo "  .::::::-+%%%%%%%@@*@@@@@#++*#++++*::::::   "
	@echo "   ::::::-+%%%%%%@@@@@@@@#++*#++++#-::::::   "
	@echo "   :::::::@@@%%@@@@@@@@@%++**+++**:::::::.   "
	@echo "   .::::::%@@@@@@@@@%@@#++**+++*@::::::::    "
	@echo "    :::::::@@@@@@@@@@@#++**+++#@@:::::::.    "
	@echo "    .::::::%%******@%%++**+++%@@@:::::::     "
	@echo "     .:::::*%*+++++%%#++%++*@@%%%::::::.     "
	@echo "      ::::::%%++++*%%*+**+%@@%%%%:::::.      "
	@echo "      .:::-+%%#+++*%%++#*%@%@@@%@@@%*+       "
	@echo "       :#@%%%%#+++*%%++#@@%%%%%%%%%%%:       "
	@echo "        +%%%%@#*++*%%*%@%%%%%%%%%%%%:        "
	@echo "         :%%%%%%@@@@@@%%%%%%%%%%%%#          "
	@echo "           %%%%%%%%%%@%%%%%%%%%%%*           "
	@echo "            .%%%%%%%%@%%%%%%%%%#             "
	@echo "              .*%%%%%%%%%%%%%-.              "
	@echo "                 :-=#%%%*-:.                 $(RESET)"
	@sleep 1

# Build the libft library silently
$(LIBFT):
	@$(MAKE) -C $(LIBFT_DIR) --silent

# Build the ft_printf library silently
$(PRINTF):
	@$(MAKE) -C $(PRINTF_DIR) --silent

# Compile the client
$(NAME_CLIENT): $(OBJS_CLIENT) $(LIBFT) $(PRINTF)
	$(CC) $(CFLAGS) $(OBJS_CLIENT) $(LIBFT) $(PRINTF) $(INCLUDES) -o $(NAME_CLIENT)

# Compile the server
$(NAME_SERVER): $(OBJS_SERVER) $(LIBFT) $(PRINTF)
	$(CC) $(CFLAGS) $(OBJS_SERVER) $(LIBFT) $(PRINTF) $(INCLUDES) -o $(NAME_SERVER)

# Clean object files
clean:
	@$(MAKE) -C $(LIBFT_DIR) clean --silent
	@$(MAKE) -C $(PRINTF_DIR) clean --silent
	rm -f $(OBJS_CLIENT) $(OBJS_SERVER)

# Remove compiled binaries and libraries
fclean: clean
	@$(MAKE) -C $(LIBFT_DIR) fclean --silent
	@$(MAKE) -C $(PRINTF_DIR) fclean --silent
	rm -f $(NAME_CLIENT) $(NAME_SERVER)

# Rebuild everything
re: fclean all

.PHONY: all clean fclean re
