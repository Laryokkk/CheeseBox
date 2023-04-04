export const load = async ({ params }) => {
    const { section } = params;

    const links = [
        { title: "Caseifici", href: "/gestione/consorzio/caseifici", active: true },
        { title: "Statistica", href: "/gestione/consorzio/statistica" },
        { title: "Vendita", href: "/gestione/consorzio/vendita" },
    ];

    return { section, links };
}