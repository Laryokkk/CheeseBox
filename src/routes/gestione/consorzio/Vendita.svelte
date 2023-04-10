<script>
    import HeaderSection from "../HeaderSection.svelte";
    import Check from "$lib/components/check/Check.svelte";
    import Input from "$lib/components/input/Input.svelte";
    import Button from "$lib/components/button/Button.svelte";
    import { fetchPost } from "$lib/utils/util-fetch.js";

    $: isButtonDisabled = true;
    $: checkValue = '';

    let elForm;

    const handlerInput = () => {
        const valueList = Object.values(getObjectsValue());

        isButtonDisabled = false;

        valueList.forEach((vl) => {
            if (!vl || vl === "") isButtonDisabled = true;
        });
    };

    const handlerClickSubmit = async () => {
        const fetchInput = getObjectsValue();
        const url = "http://localhost:8888/vendita_forme.php";

        await fetchPost(url, fetchInput).then(async (fetchResponce) => {
            const { status, data } = fetchResponce;

            if (status >= 400) return;

            data.forEach((rec) => {
                checkValue += `FORMA VENDUTA ---> Codice: ${rec.forma_code} / Stagionatura: ${rec.forma_stagionatura} / Scelta: ${rec.forma_scelta} / Prezzo: ${rec.forma_price_sell} \n`;
            });

            setTimeout(() => {
                checkValue = "";
            }, 10000);
        });
    };

    const getObjectsValue = () => {
        return {
            quantita: elForm.querySelector(".input-quantita").value,
            scelta: elForm.querySelector(".input-scelta").value,
            stagionatura: elForm.querySelector(".input-stagionatura").value,
            nome: elForm.querySelector(".input-nome").value,
            iva: elForm.querySelector(".input-iva").value,
            prezzo: elForm.querySelector(".input-prezzo").value,
        };
    };
</script>

<section class="container">
    <HeaderSection />
    <form class="form-vendita" bind:this={elForm}>
        <h4 class="text">
            <span class="text-accent">Forme Vendita</span>
        </h4>
        <div class="container-form">
            <div class="wrapper">
                <div class="container-input">
                    <h5 class="text">Quantita:</h5>
                    <Input
                        type="number"
                        className="input-quantita"
                        required="true"
                        parentHandlerInput={handlerInput}
                    />
                </div>
                <div class="container-input">
                    <h5 class="text">Scelta:</h5>
                    <Input
                        type="select"
                        className="input-scelta"
                        options={["Prima", "Seconda"]}
                        required="true"
                        parentHandlerInput={handlerInput}
                    />
                </div>
                <div class="container-input">
                    <h5 class="text">Stagionatura:</h5>
                    <Input
                        type="select"
                        className="input-stagionatura"
                        options={["12", "24", "30", "36"]}
                        required="true"
                        parentHandlerInput={handlerInput}
                    />
                </div>
            </div>
            <div class="wrapper">
                <div class="container-input">
                    <h5 class="text">Nome azienda:</h5>
                    <Input
                        type="text"
                        className="input-nome"
                        required="true"
                        parentHandlerInput={handlerInput}
                    />
                </div>
                <div class="container-input">
                    <h5 class="text">IVA:</h5>
                    <Input
                        type="text"
                        className="input-iva"
                        required="true"
                        parentHandlerInput={handlerInput}
                    />
                </div>
                <div class="container-input">
                    <h5 class="text">Prezzo per forma:</h5>
                    <Input
                        type="number"
                        className="input-prezzo"
                        required="true"
                        parentHandlerInput={handlerInput}
                    />
                </div>
            </div>
        </div>
        <Button
            text="Salva"
            disabled={isButtonDisabled}
            handlerClick={handlerClickSubmit}
        />
    </form>
    <Check value={checkValue}/>
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
