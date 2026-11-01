import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import { bunny } from 'laravel-vite-plugin/fonts';

export default defineConfig({
  plugins: [
    laravel({
      input: ['resources/css/app.css', 'resources/js/app.js', 'resources/css/adminlte.css', 'resources/js/adminlte.js'],
      refresh: true,
      fonts: [
        bunny('Instrument Sans', {
          weights: [400, 500, 600],
        }),
      ],
    }),
  ],
  server: {
    host: true,
    origin: 'http://localhost:5173',
    hmr: {
      host: 'localhost',
    },
    watch: {
      ignored: ['**/storage/framework/views/**'],
    },
  },
});
