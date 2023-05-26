import type { Request, Express, Response } from 'express';
import express from 'express';

const app: Express = express();
const port = 3000;

app.get('/', (_req: Request, res: Response) => {
	res.send('Express + TypeScript Server');
});

app.listen(port, () => {
	console.log(`⚡️[server]: Server is running at http://localhost:${port}`);
});
