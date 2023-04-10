import { fetchPost } from "$lib/utils/util-fetch.js";

export const load = async ({ params }) => {
    const { section } = params;

    const links = [
        { title: "Caseifici", href: "/gestione/consorzio/caseifici/lombarda", active: section.includes('caseifici') },
        { title: "Statistica", href: "/gestione/consorzio/statistica", active: section.includes('statistica') },
        { title: "Vendita", href: "/gestione/consorzio/vendita", active: section.includes('vendita') },
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
    const start = '2023-04-01';
    const end = '2023-04-30';

    await fetchPost(`${url_home}/get_milk.php`, { start, end })
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

    await fetchPost(`${url_home}/get_milk.php`, { })
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

    // -----------------------------------------

    await fetchPost(`${url_home}/get_forme_in_stagionatura.php`, { })
        .then((fetchResponce) => {
            const { status, data } = fetchResponce;

            if (status >= 400) return;

            data.forEach(({ forma_stagionatura }) => {
                switch (forma_stagionatura) {
                    case 12:
                        content.forme.stagionatura.m12 += 1
                        break;
                    case 24:
                        content.forme.stagionatura.m24 += 1
                        break;
                    case 30:
                        content.forme.stagionatura.m30 += 1
                        break;
                    case 36:
                        content.forme.stagionatura.m36 += 1
                        break;
                }
            });
        });

    await fetchPost(`${url_home}/get_forme_in_negozio.php`, { })
        .then((fetchResponce) => {
            const { status, data } = fetchResponce;

            if (status >= 400) return;

            data.forEach(({ forma_stagionatura }) => {
                switch (forma_stagionatura) {
                    case 12:
                        content.forme.store.m12 += 1
                        break;
                    case 24:
                        content.forme.store.m24 += 1
                        break;
                    case 30:
                        content.forme.store.m30 += 1
                        break;
                    case 36:
                        content.forme.store.m36 += 1
                        break;
                }
            });
        });

    // -----------------------------------------

    await fetchPost(`${url_home}/get_forme_prodotte.php`, { })
        .then((fetchResponce) => {
            const { status, data } = fetchResponce;

            if (status >= 400) return;

            content.all.forme.prodotte = Object.values(data)[0];

        });

    await fetchPost(`${url_home}/get_forme_prodotte.php`, { start, end })
        .then((fetchResponce) => {
            const { status, data } = fetchResponce;

            if (status >= 400) return;

            content.current.forme.prodotte = Object.values(data)[0];

        });

    // -----------------------------------------

    await fetchPost(`${url_home}/get_forme_vendute.php`, { })
        .then((fetchResponce) => {
            const { status, data } = fetchResponce;

            if (status >= 400) return;

            content.all.forme.vendute = Object.values(data)[0];

        });

    await fetchPost(`${url_home}/get_forme_vendute.php`, { start, end })
        .then((fetchResponce) => {
            const { status, data } = fetchResponce;

            if (status >= 400) return;

            content.current.forme.vendute = Object.values(data)[0];

        });

    return { section, links, content };
}