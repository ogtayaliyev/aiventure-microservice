// Configuration de l'application
export const siteConfig = {
  name: "AIVenture",
  description: "Plateforme de microservices IA nouvelle génération",
  url: "https://aiventure.com",
  ogImage: "https://aiventure.com/og.jpg",
  links: {
    twitter: "https://twitter.com/aiventure",
    github: "https://github.com/aiventure",
  },
};

// Configuration de l'API
export const apiConfig = {
  baseURL: process.env.NEXT_PUBLIC_API_URL || "http://localhost:8000",
  timeout: 10000,
};
