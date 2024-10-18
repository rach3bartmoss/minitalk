🛰️ Minitalk Project

Minitalk is a project that demonstrates how two processes (a client and a server) can communicate using UNIX signals (SIGUSR1 and SIGUSR2). The client sends a message to the server, bit by bit, and the server reconstructs the message on its side, printing it character by character. The server responds to the client after receiving each bit, ensuring synchronized communication. 🚀

📋 How It Works

Server: 🖥️

The server listens for signals from the client, reconstructs the message from the bits it receives, and prints the message to the terminal.

Client: 📡

The client sends each character of a string to the server, bit by bit, using signals. It waits for acknowledgment from the server after each bit is transmitted.

🛠️ Compilation:

You can easily compile both the client and the server using the provided Makefile.

```bash
make
```


🏃 Running the Project:

Start the Server 🖥️: 

First, run the server, which will wait for signals from the client:

```bash
./server
```

The server will display its PID. You'll need this to send messages!

Send a Message from the Client 📡: 

Open another terminal and use the client to send a message to the server by providing the server's PID and your message:

```bash
./client <server_pid> "Hello, World!"
```

Example:

```bash
./client 12345 "Hello, World!"
```


Message Transmission 💬: 

The client will send the message bit by bit, and the server will print it out! The whole process happens through signal-based communication.

💡 Purpose

This project is a great way to:

Learn about signals and inter-process communication (IPC) in UNIX.

Understand how to send and receive data bit-by-bit using low-level system calls like kill().

Synchronize two processes effectively using signal handlers and acknowledgment flags.

📂 Files

client.c: Code for the client that sends the message.

server.c: Code for the server that receives and processes the message.

minitalk.h: Header file containing shared declarations.

Makefile: Automates the compilation of the client and server.


🎯 Goals

Build a deeper understanding of how to manage asynchronous signal communication between processes.
Implement reliable data transfer between two separate programs.

🌟 Happy Coding with Minitalk! 🌟

