import { Request } from 'express';
import { User } from '../libs/security';

declare module 'express' {
  interface Request {
    user?: User
  }
}

