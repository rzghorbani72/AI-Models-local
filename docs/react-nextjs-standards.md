# React 19 & Next.js 15 - Latest Standards (Nov 2025)

## React 19 Standards

### Component Patterns

#### ✅ DO: Functional Components with Hooks
```typescript
// Modern React 19 approach
import { useState, useCallback } from 'react';

interface CounterProps {
  initialValue?: number;
}

export default function Counter({ initialValue = 0 }: CounterProps) {
  const [count, setCount] = useState(initialValue);

  const increment = useCallback(() => {
    setCount(prev => prev + 1);
  }, []);

  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={increment}>Increment</button>
    </div>
  );
}
```

#### ❌ DON'T: Class Components
```typescript
// Outdated - avoid in new code
class Counter extends React.Component {
  // ...
}
```

### Server Components (React 19+)

```typescript
// 'use server' marks this as a Server Component
// Data fetching, database queries here
import { db } from '@/lib/db';

interface User {
  id: string;
  name: string;
  email: string;
}

export async function UserList() {
  const users: User[] = await db.users.findMany();

  return (
    <ul>
      {users.map(user => (
        <li key={user.id}>{user.name}</li>
      ))}
    </ul>
  );
}
```

### Server Actions (React 19+)

```typescript
// File: app/actions.ts
'use server';

export async function createUser(name: string, email: string) {
  const user = await db.users.create({ data: { name, email } });
  revalidatePath('/users');
  return user;
}

// File: app/components/UserForm.tsx
'use client';

import { createUser } from '@/app/actions';

export function UserForm() {
  async function handleSubmit(formData: FormData) {
    const name = formData.get('name') as string;
    const email = formData.get('email') as string;
    await createUser(name, email);
  }

  return (
    <form action={handleSubmit}>
      <input name="name" required />
      <input name="email" type="email" required />
      <button type="submit">Create User</button>
    </form>
  );
}
```

### Suspense for Data Loading (React 19+)

```typescript
import { Suspense } from 'react';

function UserListSkeleton() {
  return <div>Loading users...</div>;
}

export function Page() {
  return (
    <Suspense fallback={<UserListSkeleton />}>
      <UserList />
    </Suspense>
  );
}
```

### Use Client Directive (When Needed)

```typescript
// ONLY use 'use client' for interactive components
'use client';

import { useState } from 'react';

export function InteractiveComponent() {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <div>
      <button onClick={() => setIsOpen(!isOpen)}>Toggle</button>
      {isOpen && <p>Content</p>}
    </div>
  );
}
```

---

## Next.js 15 Standards

### App Router (Not Pages Router)

```
app/
├── layout.tsx          # Root layout
├── page.tsx            # Home page /
├── users/
│   ├── layout.tsx      # Users layout
│   ├── page.tsx        # Users list /users
│   ├── [id]/
│   │   └── page.tsx    # User detail /users/[id]
│   └── new/
│       └── page.tsx    # Create user /users/new
└── api/
    └── users/
        └── route.ts    # API endpoint /api/users
```

### Metadata API (SEO)

```typescript
import { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'Users - My App',
  description: 'List of all users',
  keywords: ['users', 'app'],
  openGraph: {
    title: 'Users',
    description: 'List of all users',
    type: 'website',
    url: 'https://example.com/users',
  },
};

export default function UsersPage() {
  return <div>Users</div>;
}
```

### Dynamic Metadata

```typescript
import { Metadata } from 'next';

interface Props {
  params: { id: string };
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const user = await fetch(`/api/users/${params.id}`).then(r => r.json());

  return {
    title: user.name,
    description: `Profile of ${user.name}`,
  };
}

export default function UserPage({ params }: Props) {
  return <div>User {params.id}</div>;
}
```

### API Routes (Latest)

```typescript
// app/api/users/route.ts
import { NextRequest, NextResponse } from 'next/server';

export async function GET(request: NextRequest) {
  const users = await db.users.findMany();
  return NextResponse.json(users);
}

export async function POST(request: NextRequest) {
  const body = await request.json();
  const user = await db.users.create({ data: body });
  return NextResponse.json(user, { status: 201 });
}

// app/api/users/[id]/route.ts
export async function GET(request: NextRequest, { params }: { params: { id: string } }) {
  const user = await db.users.findUnique({ where: { id: params.id } });
  if (!user) {
    return NextResponse.json({ error: 'Not found' }, { status: 404 });
  }
  return NextResponse.json(user);
}
```

### Middleware (Edge)

```typescript
// middleware.ts
import { NextRequest, NextResponse } from 'next/server';

export function middleware(request: NextRequest) {
  const token = request.cookies.get('auth-token');

  if (!token && request.nextUrl.pathname.startsWith('/admin')) {
    return NextResponse.redirect(new URL('/login', request.url));
  }

  return NextResponse.next();
}

export const config = {
  matcher: ['/admin/:path*', '/api/:path*'],
};
```

### Environment Variables

```bash
# .env.local
DATABASE_URL=postgresql://...
NEXT_PUBLIC_API_URL=https://api.example.com
SECRET_KEY=your-secret

# NEXT_PUBLIC_ prefix makes it available to browser
# Other variables only on server
```

```typescript
// app/layout.tsx
const apiUrl = process.env.NEXT_PUBLIC_API_URL; // Browser
const secretKey = process.env.SECRET_KEY; // Server only

export default function RootLayout({ children }) {
  return (
    <html>
      <body>{children}</body>
    </html>
  );
}
```

---

## TypeScript Best Practices (2025)

### Strict Type Checking

```typescript
// tsconfig.json
{
  "compilerOptions": {
    "strict": true,
    "strictNullChecks": true,
    "strictFunctionTypes": true,
    "noImplicitThis": true,
    "noImplicitAny": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "exactOptionalPropertyTypes": true
  }
}
```

### Type-Safe Props

```typescript
interface ButtonProps {
  label: string;
  onClick: (event: React.MouseEvent<HTMLButtonElement>) => void;
  variant?: 'primary' | 'secondary';
  disabled?: boolean;
}

export function Button({ label, onClick, variant = 'primary', disabled = false }: ButtonProps) {
  return (
    <button onClick={onClick} className={variant} disabled={disabled}>
      {label}
    </button>
  );
}
```

### Type-Safe API Responses

```typescript
interface ApiResponse<T> {
  success: boolean;
  data?: T;
  error?: string;
}

interface User {
  id: string;
  name: string;
  email: string;
}

async function getUser(id: string): Promise<ApiResponse<User>> {
  try {
    const response = await fetch(`/api/users/${id}`);
    const data = await response.json();
    return { success: true, data };
  } catch (error) {
    return { success: false, error: error instanceof Error ? error.message : 'Unknown error' };
  }
}
```

---

## Testing Standards (2025)

### Jest/Vitest Setup

```typescript
// __tests__/Counter.test.ts
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import Counter from '@/components/Counter';

describe('Counter', () => {
  it('increments count on button click', async () => {
    const user = userEvent.setup();
    render(<Counter initialValue={0} />);

    const button = screen.getByRole('button', { name: /increment/i });
    await user.click(button);

    expect(screen.getByText(/count: 1/i)).toBeInTheDocument();
  });
});
```

---

## Performance Optimizations (2025)

### Image Optimization

```typescript
import Image from 'next/image';

export function ProductImage() {
  return (
    <Image
      src="/product.jpg"
      alt="Product"
      width={400}
      height={400}
      priority
    />
  );
}
```

### Code Splitting

```typescript
import dynamic from 'next/dynamic';

const HeavyComponent = dynamic(() => import('@/components/Heavy'), {
  loading: () => <p>Loading...</p>,
});

export function Page() {
  return <HeavyComponent />;
}
```

### Memoization

```typescript
import { memo, useMemo } from 'react';

interface ListProps {
  items: string[];
}

export const OptimizedList = memo(function List({ items }: ListProps) {
  const sortedItems = useMemo(() => {
    return [...items].sort();
  }, [items]);

  return (
    <ul>
      {sortedItems.map(item => <li key={item}>{item}</li>)}
    </ul>
  );
});
```

---

## Security Best Practices (2025)

### Never Hardcode Secrets

```typescript
// ✅ CORRECT: Use environment variables
const apiKey = process.env.API_KEY;

// ❌ WRONG: Never hardcode
const apiKey = 'sk-1234567890';
```

### CSRF Protection

```typescript
// Next.js includes CSRF protection by default with server actions
'use server';

export async function updateProfile(formData: FormData) {
  // Automatically protected against CSRF
  // No need for additional tokens
}
```

### Input Validation

```typescript
import { z } from 'zod';

const userSchema = z.object({
  name: z.string().min(1).max(100),
  email: z.string().email(),
});

export async function createUser(data: unknown) {
  const validated = userSchema.parse(data);
  // Now `validated` is type-safe
  return db.users.create({ data: validated });
}
```

---

## Deployment Best Practices (2025)

### Environment-Specific Configs

```typescript
// lib/config.ts
export const config = {
  apiUrl: process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3000',
  isDev: process.env.NODE_ENV === 'development',
  isProd: process.env.NODE_ENV === 'production',
};
```

---

## Common Deprecated Patterns to Avoid

| ❌ Old (Avoid) | ✅ New (Use) |
|---|---|
| Pages Router | App Router |
| `getStaticProps` | `generateStaticParams` |
| `getServerSideProps` | Server Components |
| `_document.js` | `RootLayout` |
| Class Components | Functional Components |
| Fetch in useEffect | Server Components or `useEffect` with cleanup |
| `next/image` placeholder | `blurDataURL` prop |

---

## Resources

- React 19 Docs: https://react.dev
- Next.js 15 Docs: https://nextjs.org/docs
- TypeScript: https://www.typescriptlang.org/docs
- Zod Validation: https://zod.dev

**Last Updated:** November 2025
