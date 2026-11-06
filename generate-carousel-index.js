const fs = require('fs');
const path = require('path');

const dirPath = path.join(__dirname, 'public/images/carousels');
const outputPath = path.join(dirPath, 'images.json');

if(!fs.existsSync(dirPath)) fs.mkdirSync(dirPath, { recursive: true });

fs.readdir(dirPath, (err, files) => {
  if(err) return console.error('Gagal membaca folder carousel:', err);

  const imageFiles = files.filter(file =>
    file !== 'images.json' && /\.(jpg|jpeg|png|webp|gif|svg)$/i.test(file)
  );

  fs.writeFileSync(outputPath, JSON.stringify(imageFiles, null, 2));
  console.log(`Sukses: ${imageFiles.length} foto carousel terdaftar di images.json`);
});
