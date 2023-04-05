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
                racolto: 1000,
                lavorato: 1200,
            },
            forme: {
                prodotte: 430,
                vendute: 210,
            },
            ricavo: {
                totale: 3000,
                grezzo: 200,
            },
        },
        past: {
            late: {
                racolto: 2000,
                lavorato: 1500,
            },
            forme: {
                prodotte: 230,
                vendute: 110,
            },
            ricavo: {
                totale: 6000,
                grezzo: 500,
            },
        },
        forme: {
            staggionatura: {
                m12: 120,
                m24: 2220,
                m30: 460,
                m36: 120,
            },
            negozio: {
                m12: 540,
                m24: 270,
                m30: 180,
                m36: 900,
            },
        },
    };

    return { section, links, content };
}