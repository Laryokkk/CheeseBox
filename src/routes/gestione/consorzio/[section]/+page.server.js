export const load = async ({ params }) => {
    const { section } = params;

    const links = [
        { title: "Caseifici", href: "/gestione/consorzio/caseifici", active: section.includes('caseifici') },
        { title: "Statistica", href: "/gestione/consorzio/statistica", active: section.includes('statistica') },
        { title: "Vendita", href: "/gestione/consorzio/vendita", active: section.includes('vendita') },
    ];

    return { section, links };
}