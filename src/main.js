import * as core from "@actions/core";
import * as glob from "@actions/glob";
import path from 'node:path';
import { compileFile } from './tools.js'

const Basic = {
    titleMsg: `
  _                                 ____            _   _       _
 | |       __ _   _ __     __ _    | __ )   _   _  (_) | |   __| |   ___   _ __
 | |      / _' | | '_ \\   / _' |   |  _ \\  | | | | | | | |  / _' |  / _ \\ | '__|
 | |___  | (_| | | | | | | (_| |   | |_) | | |_| | | | | | | (_| | |  __/ | |
 |_____|  \\__,_| |_| |_|  \\__, |   |____/   \\__,_| |_| |_|  \\__,_|  \\___| |_|
                          |___/
    `, lineMsg: '-'.repeat(45)
};


export async function run() {
    try {
        core.info(Basic.titleMsg);

        core.info(Basic.lineMsg);
        core.info("Build language files...")
        core.info(Basic.lineMsg);

        const source_dir = path.resolve(core.getInput('dir') || process.cwd())
        const globber = await glob.create(path.join(source_dir, '**/*.po'));
        const files = await globber.glob();

        core.startGroup('Initialization');
        core.info(`Project root: ${source_dir}`);
        core.info(`Found: ${files.length} .po files`);
        core.endGroup();

        if (files.length === 0) {
            core.warning('No .po files found to compile.');
            return;
        }

        // const results = [];

        for (const file of files) {
            const parsedPath = path.parse(file);
            const moFilePath = path.join(parsedPath.dir, `${parsedPath.name}.mo`);

            await core.group(`Processing: ${file}`, async () => {
                try {
                    const sizeKB = await compileFile(file, moFilePath)
                    core.info(`Successfully compiled to ${moFilePath}`);
                    core.info(`Size: ${sizeKB} KB`);

                    // results.push({ file: file, status: 'Success', size: `${sizeKB} KB` });
                } catch (err) {
                    core.error(`Failed to compile ${file}: ${err.message}`);
                    // results.push({ file: file, status: 'Failed', size: '-' });
                }
            });
        }

        // const summary = core.summary
        //     .addHeading('Build Language Files Report')
        //     .addRaw('All `.po` files have been processed.')
        //     .addTable([
        //         [{ data: 'File Name', header: true }, { data: 'Status', header: true }, { data: 'Size', header: true }],
        //         ...results.map(r => [r.file, r.status, r.size])
        //     ]);
        //
        // if (process.env.GITHUB_STEP_SUMMARY) {
        //     await summary.write();
        // } else {
        //     core.info("--- [DEBUG: STEP SUMMARY CONTENT] ---");
        //     core.info(summary.stringify());
        //     core.info("-------------------------------------");
        // }

        core.info("\n" + Basic.lineMsg);
        core.info("All tasks finished successfully!");
        core.info(Basic.lineMsg);

    } catch (error) {
        // Fail the workflow run if an error occurs
        if (error instanceof Error) core.setFailed(error.message)
    }
}

