import type { NextApiRequest, NextApiResponse } from "next";

const logUrl = process.env.LOG_URL;

const FluentClient = require("@fluent-org/logger").FluentClient;
const logger = new FluentClient("web.test", {
  socket: {
    host: "localhost",
    port: 24224,
    timeout: 3000,
  },
});

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  if (req.method === "POST") {
    const insert = req.body;

    // Input HTTP
    // fetch(`${logUrl}web.test`, {
    //   method: "POST",
    //   headers: {
    //     "Content-Type": "application/json",
    //   },
    //   body: JSON.stringify(insert),
    // });

    // Input Forward
    logger.emit(insert);

    return res.status(200).send({
      code: 200,
      error: 0,
      message: "Successfully added data.",
      data: insert,
    });
  }
}
