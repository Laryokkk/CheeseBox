export const deleteAllSpaces = (text) => {
    return text.replaceAll(/\s/g, '');
}