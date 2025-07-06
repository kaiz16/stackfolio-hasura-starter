<h1 align='center'>Stackfolio Hasura Starter</h1>

<h3 align="center">To get the environment variables and login credentials, please contact admin.</h3>

## Overview

Stackfolio Hasura Starter is a Hasura GraphQL engine that is connected to the Supabase PostgreSQL database. It provides a GraphQL API for interacting with the database.

## Running Locally

**Note 1**: This guide assumes you are using a Mac or Linux machine, if you are using Windows, you can use the Windows Subsystem for Linux (WSL) to run the following commands.  
**Note 2**: Please make sure you have Docker installed on your machine. If you don't have Docker installed, you can install it from [here](https://docs.docker.com/get-docker/).  
**Note 3**: You only need to run `chmod` commands one time. After that, you can skip them.

1. **Install Dependencies and Make the Scripts Executable**

   ```bash
   npm install
   chmod +x runner-*.sh
   ```

2. **Setup Environment Variables:**

   - Copy the `.env.example` file to `.env.development`. This file contains sample environment variable values. You can contact the team lead for the actual values of the environment variables.

   **Contact the team lead for the actual values of the environment variables.**

   ```bash
    cp .env.example .env.development
   ```

3. **Start the Server:**

   ```bash
   ./runner-start-dev.sh
   ```

   Make sure you have the appropriate `.env` file with appropriate values.

   This will start the Hasura GraphQL engine. You can access the Hasura console at: http://localhost:8000/console

4. **Stop the Server:**

   ```bash
   ./runner-destroy-dev.sh
   ```

## Migration & Metadata

- Install the Hasura CLI globally if you haven't already:

```bash
npm install -g hasura-cli
```

- Use console

```bash
hasura console
```

- To apply migrations, run the following command:

```
hasura migrate apply
```

- Check the status of the migrations

```
hasura migrate status
```

- To export metadata, run the following command:

```
hasura metadata export
```

Refer to the [Hasura CLI documentation](https://hasura.io/docs/latest/hasura-cli/) for more details on using the CLI.

## API Documentation

Console URL: _TBD_

GraphQL Endpoint: _TBD_

Admin Secret: **Contact the team lead for the actual value of the admin secret.**
