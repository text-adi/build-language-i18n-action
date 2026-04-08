import * as fs from "node:fs";
import gettextParser from "gettext-parser"


export async function compileFile(poPath, moPath) {
    const input = fs.readFileSync(poPath);
    const po = gettextParser.po.parse(input);
    const output = gettextParser.mo.compile(po);

    fs.writeFileSync(moPath, output);

    const stats = fs.statSync(moPath);
    return (stats.size / 1024).toFixed(2);
}