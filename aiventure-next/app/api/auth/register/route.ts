import { NextRequest, NextResponse } from "next/server";

// Route d'authentification - Register
export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { email, password, name } = body;

    // TODO: Implémenter la logique d'inscription avec votre microservice
    
    return NextResponse.json({
      success: true,
      message: "Register endpoint ready",
    });
  } catch (error) {
    return NextResponse.json(
      { success: false, message: "Invalid request" },
      { status: 400 }
    );
  }
}
