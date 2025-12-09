"use client";

import Link from "next/link";
import { useState } from "react";

export default function Header() {
  const [isMenuOpen, setIsMenuOpen] = useState(false);

  return (
    <nav className="fixed top-0 w-full z-50 bg-black/80 backdrop-blur-lg border-b border-zinc-800">
      <div className="max-w-7xl mx-auto px-6 lg:px-8">
        <div className="flex items-center justify-between h-16">
          <Link href="/" className="flex items-center gap-2">
            <div className="w-8 h-8 bg-gradient-to-br from-purple-500 to-pink-500 rounded-lg"></div>
            <span className="text-xl font-bold">AIVenture</span>
          </Link>

          <div className="hidden md:flex items-center gap-8">
            <Link href="/#features" className="text-zinc-400 hover:text-white transition-colors">
              Fonctionnalités
            </Link>
            <Link href="/#pricing" className="text-zinc-400 hover:text-white transition-colors">
              Tarifs
            </Link>
            <Link href="/about" className="text-zinc-400 hover:text-white transition-colors">
              À propos
            </Link>
          </div>

          <div className="flex items-center gap-4">
            <Link href="/login" className="text-zinc-400 hover:text-white transition-colors">
              Connexion
            </Link>
            <Link
              href="/signup"
              className="bg-gradient-to-r from-purple-500 to-pink-500 px-6 py-2 rounded-full hover:opacity-90 transition-opacity"
            >
              Commencer
            </Link>
          </div>
        </div>
      </div>
    </nav>
  );
}
