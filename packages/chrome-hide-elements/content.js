const host = location.hostname;
const selectors = Object.entries(rules)
  .filter(([domain]) => host === domain || host.endsWith("." + domain))
  .flatMap(([, s]) => s);

const style = document.createElement("style");
style.id = "hide-elements-nix";
style.textContent = selectors.join(",\n") + " { display: none !important; }";

const mount = () => {
  if (!style.isConnected) (document.head || document.documentElement).append(style);
};
mount();
new MutationObserver(mount).observe(document.documentElement, { childList: true });

chrome.storage.local.get({ enabled: true }, ({ enabled }) => {
  style.disabled = !enabled;
});
chrome.storage.onChanged.addListener((changes) => {
  if (changes.enabled) style.disabled = !changes.enabled.newValue;
});

console.debug("[hide-elements]", host, selectors);
