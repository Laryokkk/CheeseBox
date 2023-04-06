<script>
    import HeaderSection from "../HeaderSection.svelte";
    import Check from "$lib/components/check/Check.svelte";
    import Input from "$lib/components/input/Input.svelte";
    import Button from "$lib/components/button/Button.svelte";
</script>

<section class="container">
    <HeaderSection />
    <form class="form-vendita">
        <h4 class="text text-accent">Forme Vendita</h4>
        <div class="container-form">
            <div class="wrapper">
                <div class="container-input">
                    <h5 class="text">Quantita:</h5>
                    <Input type="number" required="true" />
                </div>
                <div class="container-input">
                    <h5 class="text">Scelta:</h5>
                    <Input type="select" options={[]} required="true" />
                </div>
                <div class="container-input">
                    <h5 class="text">Stagionatura:</h5>
                    <Input type="select" options={[]} required="true" />
                </div>
            </div>
            <div class="wrapper">
                <div class="container-input">
                    <h5 class="text">Nome azienda:</h5>
                    <Input type="text" required="true" />
                </div>
                <div class="container-input">
                    <h5 class="text">IVA:</h5>
                    <Input type="text" required="true" />
                </div>
                <div class="container-input">
                    <h5 class="text">Prezzo per forma:</h5>
                    <Input type="number" required="true" />
                </div>
            </div>
        </div>
        <Button text="Salva" />
    </form>
    <Check />
</section>

<style>
    section.container {
        height: 90%;

        padding: 2rem 4vw;

        display: flex;
        justify-content: flex-start;
        flex-direction: column;
        gap: 6rem;
    }

    form.form-vendita {
        display: flex;
        align-items: flex-start;
        flex-direction: column;
        gap: 2rem;
    }

    div.container-form {
        display: flex;
        align-items: flex-start;
        flex-direction: row;
        gap: 4rem;
    }

    div.wrapper {
        display: flex;
        align-items: flex-start;
        flex-direction: column;
        gap: 1rem;
    }

    div.container-input {
        display: flex;
        align-items: flex-start;
        flex-direction: column;
        gap: 0.2rem;
    }
</style>
