import { NextRequest, NextResponse } from "next/server";

// Route API de test
export async function GET(request: NextRequest) {
  return NextResponse.json({
    status: "success",
    message: "API is running",
    timestamp: new Date().toISOString(),
  });
}
