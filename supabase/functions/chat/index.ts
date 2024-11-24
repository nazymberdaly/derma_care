import { Anthropic } from "@anthropic/sdk";

const headers = {
  "Content-Type": "application/json",
};

const anthropic = new Anthropic({
  apiKey: Deno.env.get("ANTHROPIC_API_KEY")!,
});

async function generateLaserTreatmentAfterImg(
  imageUrl: string,
): Promise<string> {
  try {
    const imageResponse = await fetch(imageUrl);
    if (!imageResponse.ok) {
      throw new Error(`Failed to fetch image: ${imageResponse.statusText}`);
    }
    const imageBlob = await imageResponse.blob();

    // Create FormData and append image
    const formData = new FormData();
    formData.append("file", imageBlob, "image.jpg");

    const response = await fetch(
      "http://40.83.249.35:8000/api/generate-image",
      {
        method: "POST",
        body: formData,
      },
    );

    if (!response.ok) {
      throw new Error(`API request failed: ${response.statusText}`);
    }

    const data = await response.json();
    return data.output;
  } catch (error) {
    console.error("Error processing tool call:", error);
    throw error;
  }
}

async function runChat(
  facePhotoUrl: string,
  messages: Anthropic.Messages.Message[],
): Promise<{ message?: string; image?: string }> {
  const response = await anthropic.messages.create(
    {
      model: "claude-3-5-sonnet-20241022",
      max_tokens: 1000,
      system:
        "You are a dermatology-focused AI assistant designed to provide helpful recommendations.",
      messages: messages,
      tools: [
        {
          name: "generate_laser_treatment_after_img",
          description:
            "Generate an image of the skin after laser treatment on the 1st day",
          input_schema: {
            type: "object",
          },
        },
      ],
    },
  );

  const result: { message?: string; image?: string } = {};

  const text = response.content.find((content) => content.type === "text");
  if (text) {
    result.message = text.text;
  }

  const toolCall = response.content.find((content) =>
    content.type === "tool_use"
  );
  if (toolCall?.name === "generate_laser_treatment_after_img") {
    const image = await generateLaserTreatmentAfterImg(facePhotoUrl);
    result.image = image;
  }

  return result;
}

Deno.serve(async (req) => {
  const body = await req.json();

  const response = await runChat(body.facePhotoUrl, body.messages);

  console.log(response);

  return new Response(
    JSON.stringify(response),
    {
      headers: headers,
    },
  );
});
