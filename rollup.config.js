// See: https://rollupjs.org/introduction/

import json from '@rollup/plugin-json';
import commonjs from '@rollup/plugin-commonjs'
import { nodeResolve } from '@rollup/plugin-node-resolve'

const config = {
  input: 'src/index.mjs',
  output: {
    file: 'dist/index.cjs',
    format: 'cjs',
    exports: 'auto',
  },
  plugins: [
    json(), // Цей плагін вирішить проблему з iconv-lite та іншими JSON
    nodeResolve({
      exportConditions: ['node'],
      preferBuiltins: true
    }),
    commonjs() // Потрібен для перетворення CJS залежностей у ESM, щоб Rollup їх зрозумів
  ]
}

export default config