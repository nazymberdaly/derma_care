import { createClient } from "@supabase/supabase-js";
import { Anthropic } from "@anthropic/sdk";

const supabase = createClient(
  Deno.env.get("SUPABASE_URL")!,
  Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
);

const headers = {
  "Content-Type": "application/json",
};

Deno.serve(async (req) => {
  const body = await req.formData();

  const file = body.get("file");
  if (!file || !(file instanceof File)) {
    return new Response(
      JSON.stringify({ error: "No file provided" }),
      {
        status: 400,
        headers: headers,
      },
    );
  }

  // const { data, error } = await supabase.storage
  //   .from("images")
  //   .upload(`${crypto.randomUUID()}-${file.name}`, file);

  // if (error) {
  //   return new Response(
  //     JSON.stringify(error),
  //     {
  //       status: 500,
  //       headers: corsHeaders,
  //     },
  //   );
  // }

  const model = new Anthropic({
    apiKey: Deno.env.get("ANTHROPIC_API_KEY")!,
  });

  const fileContent = await file.arrayBuffer();
  const base64Image = btoa(
    String.fromCharCode(...new Uint8Array(fileContent)),
  );

  const response = await model.messages.create({
    model: "claude-3-5-sonnet-20241022",
    max_tokens: 1000,
    messages: [{
      role: "user",
      content: [
        {
          type: "image",
          source: {
            type: "base64",
            data: base64Image,
            media_type: "image/jpeg",
          },
        },
        {
          type: "text",
          text: "Please analyze this image and describe what you see.",
        },
      ],
    }],
  });

  return new Response(
    JSON.stringify(response),
    {
      headers: headers,
    },
  );
});
