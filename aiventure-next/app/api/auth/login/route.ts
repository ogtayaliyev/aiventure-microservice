import { NextRequest, NextResponse } from "next/server";

// Route d'authentification - Login
export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { email, password } = body;

    // TODO: Implémenter la logique d'authentification avec votre microservice
    // Exemple d'appel à votre API Docker
    /*
    const response = await fetch(`${process.env.API_URL}/auth/login`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ email, password })
    });
    */

    // Pour l'instant, retourner une réponse de test
    return NextResponse.json({
      success: true,
      message: "Login endpoint ready",
      // token: "your-jwt-token",
    });
  } catch (error) {
    return NextResponse.json(
      { success: false, message: "Invalid request" },
      { status: 400 }
    );
  }
}
