const locale = 'it-IT';

export const getDate = (param = new Date()) => {
    const date = new Date(param);

    return date.toLocaleDateString(locale);
};