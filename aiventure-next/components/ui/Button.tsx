import { ButtonHTMLAttributes, ReactNode } from "react";

interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: "primary" | "secondary" | "outline";
  size?: "sm" | "md" | "lg";
  children: ReactNode;
}

export default function Button({
  variant = "primary",
  size = "md",
  children,
  className = "",
  ...props
}: ButtonProps) {
  const baseStyles = "rounded-full font-semibold transition-all inline-flex items-center justify-center";
  
  const variants = {
    primary: "bg-gradient-to-r from-purple-500 to-pink-500 hover:opacity-90",
    secondary: "bg-zinc-900 border border-zinc-800 hover:bg-zinc-800",
    outline: "border border-zinc-700 hover:border-zinc-600 hover:bg-zinc-900/50",
  };

  const sizes = {
    sm: "px-4 py-2 text-sm",
    md: "px-6 py-3 text-base",
    lg: "px-8 py-4 text-lg",
  };

  return (
    <button
      className={`${baseStyles} ${variants[variant]} ${sizes[size]} ${className}`}
      {...props}
    >
      {children}
    </button>
  );
}
