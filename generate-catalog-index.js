const fs = require('fs');
const path = require('path');
const XLSX = require('xlsx');

const excelPath = path.join(__dirname, 'public/images/catalogs/nissin_catalog_data.xlsx');
const outputDir = path.join(__dirname, 'public/images/catalogs');

if (!fs.existsSync(outputDir)) fs.mkdirSync(outputDir, { recursive: true });

try {
  const workbook = XLSX.readFile(excelPath);

  workbook.SheetNames.forEach(sheetName => {
    const sheet = workbook.Sheets[sheetName];
    const jsonData = XLSX.utils.sheet_to_json(sheet);

    const outputPath = path.join(outputDir, `${sheetName}.json`);
    fs.writeFileSync(outputPath, JSON.stringify(jsonData, null, 2));
    console.log(`SUCCESS: ${sheetName} converted to JSON`);
  });
} catch (error) {
  console.error('ERR[2] mengonversi file Excel:', error);
}
