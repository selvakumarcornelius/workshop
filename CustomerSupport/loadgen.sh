#!/bin/bash
TOKEN="eyJraWQiOiJCYmRBeHlocGNRbEpBSnA4YnVVZTlUQ3ZxYTVGRm50MU1LS3hEVjNyZjFFPSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiJhOGMxMTM4MC02MGMxLTcwMjEtOTZhZi05ZTUzOWNmZTZlZjUiLCJpc3MiOiJodHRwczovL2NvZ25pdG8taWRwLnVzLXdlc3QtMi5hbWF6b25hd3MuY29tL3VzLXdlc3QtMl9HSXFvU2dJc2MiLCJjbGllbnRfaWQiOiIybGFxZ2E1a2sydm0zdGxnbnMwZWlmcHFscSIsIm9yaWdpbl9qdGkiOiI2MWNlZDYzZi0xYTM4LTQ4ZDAtODg4NS1iOGRlNjVkMzVmZWEiLCJldmVudF9pZCI6IjNjODc1MGE1LThmOWUtNGFjNC1hYmY5LTA4YzU4ZGE3M2U2NiIsInRva2VuX3VzZSI6ImFjY2VzcyIsInNjb3BlIjoiYXdzLmNvZ25pdG8uc2lnbmluLnVzZXIuYWRtaW4iLCJhdXRoX3RpbWUiOjE3OTM5MTcwNjUsImV4cCI6MTc5MzkyMDY2NSwiaWF0IjoxNzkzOTE3MDY1LCJqdGkiOiIzNmEyYTU3MC0xNWM0LTQ2NjYtOTA1ZC01NGUzNTFkYzZmNjciLCJ1c2VybmFtZSI6ImE4YzExMzgwLTYwYzEtNzAyMS05NmFmLTllNTM5Y2ZlNmVmNSJ9.rPPxhvo4B7t9r7JG6eSRtGCtgvN0QhAwoQixTDSTPgxh4RtlwAVYUXh_TvKYDD9IdDB6Ph9BswGzscLksQw5sn7hvJZDf2Ny_j3TTMWmO8t2FTXfmmUJNAYQUs_ZBd9Y4p5caxV3UpgAgiDHvDnfZ4TWEFAzASe6GbvRpRIXV2jdYxa9yqBHgtx7Y4z04ggq3hBChnlyCvP7XZo-PdmEShb5yC5ofBim8JatNxFgZbUOnvHqAZp-iMWQeu76vCkTP9Xxok0CWJjDJG_uoApOMlrX-PmglqsAy3MV-oiS7Ulzo4HJMi2DTfGTSCweqMNp8pFSwbmxnJA7gKdjKzDwEw"
GATEWAY_URL="https://customersupport-my-gateway-secure-j9a4hezdqi.gateway.bedrock-agentcore.us-west-2.amazonaws.com/customer-support-ab/invocations"

PROMPTS=(
  "What's the price of the Smart Watch?"
  "My headphones are broken, what should I do?"
  "Is PROD-002 still under warranty?"
  "What's the return policy for audio products?"
  "It stopped working. Can I get a refund?"
  "I want to return my USB-C Hub and check its warranty."
)

for i in $(seq 1 30); do
  PROMPT="${PROMPTS[$(( (i - 1) % ${#PROMPTS[@]} ))]}"
  SESSION_ID=$(python3 -c "import uuid; print(str(uuid.uuid4()) + '-' + str(uuid.uuid4())[:8])")
  echo "=== Request $i: $PROMPT ==="
  curl -s \
    -H "Authorization: Bearer $TOKEN" \
    -H "Content-Type: application/json" \
    -H "X-Amzn-Bedrock-AgentCore-Runtime-Session-Id: $SESSION_ID" \
    -d "{\"prompt\": \"$PROMPT\"}" \
    -X POST "$GATEWAY_URL"
  echo ""
  sleep 2
done
