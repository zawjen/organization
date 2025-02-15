# NestJS TypeScript Code Conventions

## 1. Project Structure

```
📦 src
 ┣ 📂 modules
 ┃ ┣ 📂 user
 ┃ ┃ ┣ 📜 user.controller.ts
 ┃ ┃ ┣ 📜 user.service.ts
 ┃ ┃ ┣ 📜 user.module.ts
 ┃ ┃ ┣ 📜 user.repository.ts
 ┃ ┃ ┗ 📜 user.entity.ts
 ┣ 📂 common
 ┃ ┣ 📜 decorators
 ┃ ┣ 📜 filters
 ┃ ┣ 📜 interceptors
 ┃ ┗ 📜 guards
 ┣ 📂 config
 ┃ ┣ 📜 database.config.ts
 ┃ ┗ 📜 app.config.ts
 ┣ 📜 main.ts
 ┗ 📜 app.module.ts
```

## 2. Naming Conventions

- **Files:** Use `kebab-case`, e.g., `user.controller.ts`
- **Classes:** Use `PascalCase`, e.g., `UserService`
- **Interfaces:** Prefix with `I`, e.g., `IUser`
- **Constants:** Use `UPPER_CASE`, e.g., `JWT_SECRET`
- **Functions & Variables:** Use `camelCase`, e.g., `getUserById`
- **Enums:** Use `PascalCase` for names and `UPPER_CASE` for values

## 3. Modules & Providers

- Each module should have its own folder inside `src/modules/`
- `@Module` should import necessary modules and export shared providers

```ts
import { Module } from '@nestjs/common';
import { UserController } from './user.controller';
import { UserService } from './user.service';
import { UserRepository } from './user.repository';

@Module({
  controllers: [UserController],
  providers: [UserService, UserRepository],
  exports: [UserService],
})
export class UserModule {}
```

## 4. Controllers

- Use `@Controller` with a plural noun (e.g., `@Controller('users')`)
- Define route methods with `@Get()`, `@Post()`, etc.
- Use DTOs for request validation

```ts
import { Controller, Get, Param } from '@nestjs/common';
import { UserService } from './user.service';

@Controller('users')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Get(':id')
  async getUser(@Param('id') id: string) {
    return this.userService.findById(id);
  }
}
```

## 5. Services

- Business logic should be placed in services, not controllers

```ts
import { Injectable } from '@nestjs/common';
import { UserRepository } from './user.repository';

@Injectable()
export class UserService {
  constructor(private readonly userRepository: UserRepository) {}

  async findById(id: string) {
    return this.userRepository.findOne(id);
  }
}
```

## 6. DTOs (Data Transfer Objects)

- Use `class-validator` decorators for validation

```ts
import { IsString, IsEmail } from 'class-validator';

export class CreateUserDto {
  @IsString()
  name: string;

  @IsEmail()
  email: string;
}
```

## 7. Entities

- Use TypeORM with decorators for defining entities

```ts
import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity()
export class User {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  name: string;

  @Column({ unique: true })
  email: string;
}
```

## 8. Middleware & Guards

- Middleware should be placed in `common/middleware/`
- Guards should be placed in `common/guards/`

```ts
import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';

@Injectable()
export class AuthGuard implements CanActivate {
  canActivate(context: ExecutionContext): boolean {
    const request = context.switchToHttp().getRequest();
    return Boolean(request.user);
  }
}
```

## 9. Error Handling

- Use exception filters for custom error handling

```ts
import { ExceptionFilter, Catch, ArgumentsHost, HttpException } from '@nestjs/common';

@Catch(HttpException)
export class HttpExceptionFilter implements ExceptionFilter {
  catch(exception: HttpException, host: ArgumentsHost) {
    const response = host.switchToHttp().getResponse();
    response.status(exception.getStatus()).json(exception.getResponse());
  }
}
```

## 10. Environment Variables

- Use `@nestjs/config` for configuration management

```ts
import { ConfigService } from '@nestjs/config';

export class AppConfig {
  constructor(private configService: ConfigService) {}
  get jwtSecret(): string {
    return this.configService.get<string>('JWT_SECRET');
  }
}
```

## 11. Testing

- Use Jest for unit testing
- Test services and controllers separately

```ts
import { Test, TestingModule } from '@nestjs/testing';
import { UserService } from './user.service';
import { UserRepository } from './user.repository';

describe('UserService', () => {
  let service: UserService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [UserService, UserRepository],
    }).compile();

    service = module.get<UserService>(UserService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
```

## 12. Code Formatting & Linting

- Use ESLint & Prettier for formatting
- Ensure `.eslintrc.json` is properly configured

```json
{
  "extends": ["@nestjs/eslint-config"],
  "rules": {
    "@typescript-eslint/no-unused-vars": "warn",
    "prettier/prettier": "error"
  }
}
```

## 13. Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat(user): add new user creation endpoint
fix(auth): resolve token expiration bug
chore(deps): update TypeORM to latest version
```

---

By following these conventions, the NestJS project remains clean, scalable, and maintainable.

