import { fetchPost } from "$lib/utils/util-fetch.js";

export const load = async ({ params }) => {
    const { section } = params;

    const links = [
        { title: "Produzione", href: "/gestione/caseificio/produzione", active: section.includes('produzione') },
        { title: "Statistica", href: "/gestione/caseificio/statistica", active: section.includes('statistica') },
        { title: "Gestione", href: "/gestione/caseificio/gestione", active: section.includes('gestione') },
    ];

    const content = {
        current: {
            late: {
                racolto: 0,
                lavorato: 0,
            },
            forme: {
                prodotte: 0,
                vendute: 0,
            },
            ricavo: {
                totale: 0,
                grezzo: 0,
            },
        },
        all: {
            late: {
                racolto: 0,
                lavorato: 0,
            },
            forme: {
                prodotte: 0,
                vendute: 0,
            },
            ricavo: {
                totale: 0,
                grezzo: 0,
            },
        },
        forme: {
            stagionatura: {
                m12: 0,
                m24: 0,
                m30: 0,
                m36: 0,
            },
            store: {
                m12: 0,
                m24: 0,
                m30: 0,
                m36: 0,
            },
        },
    };

    const url_home = "http://localhost:8888";
    const code = '0001';
    const start = '2023-04-01';
    const end = '2023-04-30';

    await fetchPost(`${url_home}/get_milk.php`, { start, end, code })
        .then((fetchResponce) => {
            const { status, data } = fetchResponce;

            if (status >= 400) return;

            data.forEach(({ milk_quantity, milk_type }) => {
                if (!milk_quantity || milk_quantity === '') return;

                if (milk_type === 'lavorato') {
                    content.current.late.lavorato += milk_quantity;
                } else if (milk_type === 'racolto') {
                    content.current.late.racolto += milk_quantity;
                }
            });
        });

    await fetchPost(`${url_home}/get_milk.php`, { code })
        .then((fetchResponce) => {
            const { status, data } = fetchResponce;

            if (status >= 400) return;

            data.forEach(({ milk_quantity, milk_type }) => {
                if (!milk_quantity || milk_quantity === '') return;

                if (milk_type === 'lavorato') {
                    content.all.late.lavorato += milk_quantity;
                } else if (milk_type === 'racolto') {
                    content.all.late.racolto += milk_quantity;
                }
            });
        });

    return { section, links, content };
}