declare global {
  namespace NodeJS {
    interface ProcessEnv {
      LOG_URL: string;
    }
  }
}

export {};
