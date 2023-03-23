import validator from 'validator';
import { filterXSS } from "./util-xss";

export const isEmpty = (value) => {
    let text = sanitizeValue(value);

    return validator.isEmpty(text);
};

export const isValidInputText = (value) => {
    let text = sanitizeValue(value);

    return !validator.isEmpty(text);
};

export const isValidInputNumber = (value) => {
    let number = sanitizeValue(value);

    return validator.isNumeric(number);
};


export const isValidInputEmail = (value) => {
    let email = sanitizeValue(value);

    return validator.isEmail(email);
};

export const isValidInputPhone = (value) => {
    let phone = sanitizeValue(value);

    return validator.isMobilePhone(phone);
};

export const isValidInputPassword = (value) => {
    let password = sanitizeValue(value);

    return validator.isStrongPassword(password);
};

const sanitizeValue = (value) => {
    return filterXSS(value);
};