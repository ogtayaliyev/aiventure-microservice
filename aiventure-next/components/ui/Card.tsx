import { ReactNode } from "react";

interface CardProps {
  children: ReactNode;
  className?: string;
  hover?: boolean;
}

export default function Card({ children, className = "", hover = true }: CardProps) {
  return (
    <div
      className={`
        p-6 rounded-2xl bg-zinc-900/50 border border-zinc-800
        ${hover ? "hover:border-zinc-700 transition-colors" : ""}
        ${className}
      `}
    >
      {children}
    </div>
  );
}
