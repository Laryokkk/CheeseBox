<script>
    import HeaderSection from "../HeaderSection.svelte";

    export let content;
</script>

<section class="container">
    <HeaderSection />
    <div class="container">
        <div class="wrapper">
            <h4 class="text">Questo messe:</h4>
            <div class="container-section">
                <div class="section-content">
                    <h5 class="text">
                        Late racolto: <span class="text-accent"
                            >{content.current.late.racolto}l</span
                        >
                    </h5>
                    <h5 class="text">
                        Late lavorato: <span class="text-accent"
                            >{content.current.late.lavorato}l</span
                        >
                    </h5>
                </div>
                <div class="section-content">
                    <h5 class="text">
                        Forme prodotte: <span class="text-accent"
                            >{content.current.forme.prodotte}pz</span
                        >
                    </h5>
                    <h5 class="text">
                        Forme vendute: <span class="text-accent"
                            >{content.current.forme.vendute}pz</span
                        >
                    </h5>
                </div>
                <div class="section-content">
                    <h5 class="text">
                        Ricavo totale: <span class="text-accent"
                            >{content.current.ricavo.totale}€</span
                        >
                    </h5>
                    <h5 class="text">
                        Ricavo grezzo: <span class="text-accent"
                            >{content.current.ricavo.grezzo}€</span
                        >
                    </h5>
                </div>
            </div>
        </div>
        <div class="wrapper">
            <h4 class="text">Scorso messe:</h4>
            <div class="container-section">
                <div class="section-content">
                    <h5 class="text">
                        Late racolto: <span class="text-accent"
                            >{content.past.late.racolto}l</span
                        >
                    </h5>
                    <h5 class="text">
                        Late lavorato: <span class="text-accent"
                            >{content.past.late.lavorato}l</span
                        >
                    </h5>
                </div>
                <div class="section-content">
                    <h5 class="text">
                        Forme prodotte: <span class="text-accent"
                            >{content.past.forme.prodotte}pz</span
                        >
                    </h5>
                    <h5 class="text">
                        Forme vendute: <span class="text-accent"
                            >{content.past.forme.vendute}pz</span
                        >
                    </h5>
                </div>
                <div class="section-content">
                    <h5 class="text">
                        Ricavo totale: <span class="text-accent"
                            >{content.past.ricavo.totale}€</span
                        >
                    </h5>
                    <h5 class="text">
                        Ricavo grezzo: <span class="text-accent"
                            >{content.past.ricavo.grezzo}€</span
                        >
                    </h5>
                </div>
            </div>
        </div>
        <div class="wrapper wrapper-extend">
            <div class="wrapper wrapper-section">
                <h4 class="text">Forme in staggionatura:</h4>
                <div class="container-section">
                    <div class="section-content">
                        <h5 class="text">
                            Ricavo totale: <span class="text-accent"
                                >{content.past.ricavo.totale}€</span
                            >
                        </h5>
                        <h5 class="text">
                            Ricavo grezzo: <span class="text-accent"
                                >{content.past.ricavo.grezzo}€</span
                            >
                        </h5>
                        <h5 class="text">
                            Ricavo totale: <span class="text-accent"
                                >{content.past.ricavo.totale}€</span
                            >
                        </h5>
                        <h5 class="text">
                            Ricavo grezzo: <span class="text-accent"
                                >{content.past.ricavo.grezzo}€</span
                            >
                        </h5>
                    </div>
                </div>
            </div>
            <div class="wrapper wrapper-section">
                <h4 class="text">Forme in negozio:</h4>
                <div class="container-section">
                    <div class="section-content">
                        <h5 class="text">
                            Ricavo totale: <span class="text-accent"
                                >{content.past.ricavo.totale}€</span
                            >
                        </h5>
                        <h5 class="text">
                            Ricavo grezzo: <span class="text-accent"
                                >{content.past.ricavo.grezzo}€</span
                            >
                        </h5>
                        <h5 class="text">
                            Ricavo totale: <span class="text-accent"
                                >{content.past.ricavo.totale}€</span
                            >
                        </h5>
                        <h5 class="text">
                            Ricavo grezzo: <span class="text-accent"
                                >{content.past.ricavo.grezzo}€</span
                            >
                        </h5>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div />
</section>

<style>
    section.container {
        height: 90%;

        padding: 2rem 4vw;

        display: flex;
        justify-content: space-between;
        flex-direction: column;
        gap: 2rem;
    }

    div.container {
        display: flex;
        justify-content: space-between;
        flex-direction: column;
        gap: 8rem;
    }

    div.wrapper {
        display: flex;
        flex-direction: column;
        gap: 2rem;
    }

    div.wrapper-extend {
        display: flex;
        flex-direction: row;
        gap: 20vw;
    }

    div.container-section {
        margin-left: 1rem;

        display: flex;
        flex-direction: row;
        gap: 3rem;
    }

    div.section-content {
        display: flex;
        gap: 1rem;
        flex-direction: column;
    }
</style>
