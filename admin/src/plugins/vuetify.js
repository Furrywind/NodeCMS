import Vue from "vue";
import Vuetify from "vuetify/lib";
import {
  mdiRadioboxBlank,
  mdiRadioboxMarked,
  mdiCheckboxBlankOutline,
  mdiCheckboxMarked,
  mdiPlus,
  mdiMenuDown,
  mdiArrowUp
} from "@mdi/js";

Vue.use(Vuetify);

export default new Vuetify({
  icons: {
    iconfont: "mdSvg",
    values: {
      radioOff: mdiRadioboxBlank,
      radioOn: mdiRadioboxMarked,
      checkboxOff: mdiCheckboxBlankOutline,
      checkboxOn: mdiCheckboxMarked,
      plus: mdiPlus,
      dropdown: mdiMenuDown,
      sort: mdiArrowUp
    }
  }
});
