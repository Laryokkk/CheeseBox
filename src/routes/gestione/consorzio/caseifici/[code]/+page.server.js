export const load = async ({ params }) => {
    const { code } = params;

    const links = [
        { title: "Lombarda", href: "/gestione/consorzio/caseifici/lombarda", active: code.includes('lombarda') },
        { title: "Milano", href: "/gestione/consorzio/caseifici/milano", active: code.includes('milano') },
        { title: "Bergamo", href: "/gestione/consorzio/caseifici/bergamo", active: code.includes('bergamo') },
        { title: "Trieste", href: "/gestione/consorzio/caseifici/trieste", active: code.includes('trieste') },
        { title: "Roma", href: "/gestione/consorzio/caseifici/roma", active: code.includes('roma') },
        { title: "Venezia", href: "/gestione/consorzio/caseifici/venezia", active: code.includes('venezia') },
    ];

    return { code, links };
}