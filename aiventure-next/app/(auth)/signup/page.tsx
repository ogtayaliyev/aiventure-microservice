"use client";

import { useState } from "react";
import Link from "next/link";
import Button from "@/components/ui/Button";

export default function SignupPage() {
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    // TODO: Implémenter la logique d'inscription
    console.log("Signup:", { name, email, password });
  };

  return (
    <div className="p-8 rounded-2xl bg-zinc-900/50 border border-zinc-800">
      <div className="text-center mb-8">
        <h1 className="text-3xl font-bold mb-2">Inscription</h1>
        <p className="text-zinc-400">Créez votre compte AIVenture</p>
      </div>

      <form onSubmit={handleSubmit} className="space-y-4">
        <div>
          <label htmlFor="name" className="block text-sm font-medium mb-2">
            Nom complet
          </label>
          <input
            id="name"
            type="text"
            value={name}
            onChange={(e) => setName(e.target.value)}
            className="w-full px-4 py-3 rounded-lg bg-black border border-zinc-800 focus:border-purple-500 focus:outline-none transition-colors"
            placeholder="Jean Dupont"
            required
          />
        </div>

        <div>
          <label htmlFor="email" className="block text-sm font-medium mb-2">
            Email
          </label>
          <input
            id="email"
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            className="w-full px-4 py-3 rounded-lg bg-black border border-zinc-800 focus:border-purple-500 focus:outline-none transition-colors"
            placeholder="votre@email.com"
            required
          />
        </div>

        <div>
          <label htmlFor="password" className="block text-sm font-medium mb-2">
            Mot de passe
          </label>
          <input
            id="password"
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            className="w-full px-4 py-3 rounded-lg bg-black border border-zinc-800 focus:border-purple-500 focus:outline-none transition-colors"
            placeholder="••••••••"
            required
          />
        </div>

        <Button type="submit" className="w-full" variant="primary" size="lg">
          Créer mon compte
        </Button>
      </form>

      <p className="text-center text-sm text-zinc-400 mt-6">
        Déjà un compte ?{" "}
        <Link href="/login" className="text-purple-400 hover:text-purple-300">
          Se connecter
        </Link>
      </p>
    </div>
  );
}
