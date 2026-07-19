const renderedFiles = (Deno.env.get("QUARTO_PROJECT_OUTPUT_FILES") ?? "")
  .split(/\r?\n/)
  .filter(Boolean);

const now = new Date();
const date = [
  now.getFullYear(),
  String(now.getMonth() + 1).padStart(2, "0"),
  String(now.getDate()).padStart(2, "0"),
].join("-");

for (const source of renderedFiles) {
  const match = source.match(/^(.*\/)?resume\.(pdf|docx)$/i);
  if (!match) continue;

  const directory = match[1] ?? "";
  const extension = match[2].toLowerCase();
  const destination = `${directory}${date}_resume.${extension}`;

  try {
    await Deno.remove(destination);
  } catch (error) {
    if (!(error instanceof Deno.errors.NotFound)) throw error;
  }

  await Deno.rename(source, destination);
  console.log(`Renamed ${source} to ${destination}`);
}
