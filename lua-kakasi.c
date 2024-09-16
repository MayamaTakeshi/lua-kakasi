#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>
#include <libkakasi.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <pthread.h>

// Define the mutex
pthread_mutex_t lock;

#define MAX_OPTIONS_LEN 1024
#define MAX_TOKENS 32

// Function to convert text using Kakasi
static int lua_kakasi_convert(lua_State *L) {
    const char *input = luaL_checkstring(L, 1);
    const char *options = luaL_optstring(L, 2, "-Ha -Ka -Ja"); // Default options
    if (strlen(options) >= MAX_OPTIONS_LEN) {
        lua_pushnil(L);
        lua_pushfstring(L, "options too large");
        return 2;
    }

    char tokens[MAX_OPTIONS_LEN];

    strcpy(tokens, options);

    char *argv[MAX_TOKENS];
    char *token = strtok(tokens, " ");  // Tokenize by space
    int argc = 0;

    argv[argc++] = "kakasi";

    // Split the string into tokens
    while (token != NULL && argc < MAX_TOKENS) {
        argv[argc++] = token;
        token = strtok(NULL, " ");
    }

    pthread_mutex_lock(&lock);

    // Initialize Kakasi
    if (kakasi_getopt_argv(argc, argv)) {
        lua_pushnil(L);
        lua_pushfstring(L, "Kakasi initialization failed with options: %s", options);
	pthread_mutex_unlock(&lock);
        return 2;
    }

    // Perform conversion
    char *result = kakasi_do((char*)input);
    if (!result) {
        lua_pushnil(L);
        lua_pushstring(L, "Conversion failed");
        kakasi_close_kanwadict();
	pthread_mutex_unlock(&lock);
        return 2;
    }

    // Return result
    lua_pushstring(L, result);

    // Clean up
    kakasi_close_kanwadict();

    pthread_mutex_unlock(&lock);

    return 1;
}

// Register the Kakasi functions
int luaopen_kakasi(lua_State *L) {
    static const struct luaL_reg kakasi_funcs[] = {
        {"convert", lua_kakasi_convert},
        {NULL, NULL}
    };

    luaL_register(L, "kakasi", kakasi_funcs);
    return 1;
}

