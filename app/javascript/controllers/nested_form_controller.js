import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="nested-form"
export default class extends Controller {
  static targets = ["container", "template"]

  add(event) {
    event.preventDefault()
    
    // Clona o conteúdo do template
    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    
    // Insere o conteúdo no contêiner
    this.containerTarget.insertAdjacentHTML('beforeend', content)
  }

  remove(event) {
    event.preventDefault()
    
    // Encontra o wrapper do campo a ser removido
    const wrapper = event.target.closest("[data-nested-form-wrapper]")
    
    // Se o campo já tem um ID, apenas o esconde e marca para ser destruído
    if (wrapper.dataset.newRecord === 'false') {
      wrapper.style.display = 'none';
      wrapper.querySelector("input[name*='_destroy']").value = '1';
    } else {
      // Se é um campo novo, apenas o remove do DOM
      wrapper.remove();
    }
  }
}