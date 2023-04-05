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

    const caseificiSource = [
        { name: 'Bella Casa', code: '12332141', region: 'lombarda' },
        { name: 'Bella Casa', code: '12332142', region: 'milano' },
        { name: 'Bella Casa', code: '12332143', region: 'bergamo' },
        { name: 'Bella Casa', code: '12332144', region: 'trieste' },
        { name: 'Bella Casa', code: '12332145', region: 'roma' },
        { name: 'Bella Casa', code: '12332146', region: 'venezia' },
        { name: 'Bella Casa', code: '12332147', region: 'milano' },
    ];

    const caseifici = caseificiSource.filter(Caseificio => code.includes(Caseificio.region));

    return { code, links, caseifici };
}