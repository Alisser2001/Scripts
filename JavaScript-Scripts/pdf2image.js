/*
OS requirements to use the script:

- Node >= 14.x
- ImageMagick
- GraphicsMagick
- GhostScript

Python libraries required:

- pdf2pic
- fs-extra
*/

const { fromPath } = require('pdf2pic');
const fs = require('fs');
const path = require('path');
const fsExtra = require('fs-extra');

const directoryPath = './public/assets/';
const outputFolder = './public/miniatures';
const outputFile = './certificatesInfo.json';

if (fs.existsSync(outputFile)) {
    fs.unlinkSync(outputFile);
}
fsExtra.emptyDirSync(outputFolder);

fs.readdir(directoryPath, (err, files) => {
    if (err) {
        console.error('Error al leer el directorio:', err);
        return;
    }

    const pdfFiles = files.filter(file => path.extname(file) === '.pdf');
    const jsonArray = pdfFiles.map(file => {
        const fileName = path.basename(file, '.pdf');
        return { name: fileName };
    });
    const jsonContent = JSON.stringify(jsonArray, null, 2);
    fs.writeFileSync(outputFile, jsonContent);
    pdfFiles.forEach(file => {
        const fileName = path.basename(file, '.pdf');
        const options = {
            density: 100,
            saveFilename: fileName,
            savePath: outputFolder,
            format: 'png',
            width: 600,
            height: 400
        };
        const convert = fromPath(`${directoryPath}/${file}`, options);

        convert(1)
            .catch((error) => {
                console.error(`Error al convertir ${file} a imagen: ${error}`);
            });
    });
});
