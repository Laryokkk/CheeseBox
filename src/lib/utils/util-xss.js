import xss from "xss";

const options = {};
const filter = new xss.FilterXSS(options);

export const filterXSS = (value) => {
    return filter.process(value);
};