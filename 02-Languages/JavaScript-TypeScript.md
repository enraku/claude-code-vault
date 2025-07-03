# JavaScript/TypeScript Rules

## Package Management
- Always check `package.json` to identify package manager: npm, yarn, or pnpm
- Use existing package manager consistently
- Check for `package-lock.json`, `yarn.lock`, or `pnpm-lock.yaml`

## TypeScript Configuration
- Follow existing `tsconfig.json` settings
- Respect strict mode settings if enabled
- Use existing path mapping and aliases
- Maintain consistent import/export patterns

## Code Style
- Follow existing ESLint configuration
- Use Prettier settings if configured
- Maintain consistent indentation (2 or 4 spaces)
- Use semicolons based on project style

## React Patterns
- Prefer functional components over class components
- Use existing state management (Redux, Zustand, Context)
- Follow existing component structure and naming
- Use existing styling approach (CSS modules, styled-components, etc.)

## Testing
- Use existing test framework (Jest, Vitest, etc.)
- Follow existing test file patterns (`*.test.ts`, `*.spec.ts`)
- Maintain test coverage for new features
- Use existing mocking patterns

## Common Commands
```bash
# Install dependencies
npm install / yarn install / pnpm install

# Run development server
npm run dev / yarn dev / pnpm dev

# Run tests
npm test / yarn test / pnpm test

# Run linting
npm run lint / yarn lint / pnpm lint

# Build project
npm run build / yarn build / pnpm build

# Type checking
npm run type-check / yarn type-check / pnpm type-check
```

## Best Practices
- Use TypeScript strict mode when available
- Implement proper error boundaries in React
- Use `const` assertions for immutable data
- Prefer `interface` over `type` for object shapes
- Use proper async/await error handling

## Framework-Specific Rules

### Next.js
- Use App Router when available
- Follow existing directory structure (`app/` or `pages/`)
- Use existing data fetching patterns
- Implement proper SEO meta tags

### Vue.js
- Use Composition API when available
- Follow existing component structure
- Use existing state management (Pinia, Vuex)
- Maintain consistent template syntax

### Angular
- Follow existing module structure
- Use existing dependency injection patterns
- Implement proper lifecycle hooks
- Use existing routing configuration

## File Organization
```
src/
├── components/     # Reusable UI components
├── pages/         # Page components (Next.js) or views
├── hooks/         # Custom React hooks
├── utils/         # Utility functions
├── types/         # TypeScript type definitions
├── services/      # API and external service calls
├── stores/        # State management
└── assets/        # Static assets
```

## Import/Export Patterns
```typescript
// Prefer named exports
export const MyComponent = () => {}

// Default exports for pages/main components
export default function HomePage() {}

// Consistent import organization
import React from 'react'
import { useState } from 'react'
import { MyService } from '../services'
import { Button } from '../components'
```

## Error Handling
```typescript
// Async operations
try {
  const data = await fetchData()
  return data
} catch (error) {
  console.error('Failed to fetch data:', error)
  throw error
}

// React error boundaries
class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props)
    this.state = { hasError: false }
  }
  
  static getDerivedStateFromError(error) {
    return { hasError: true }
  }
}
```

---
Tags: #javascript #typescript #react #vue #angular #nextjs #rules