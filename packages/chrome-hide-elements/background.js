const render = (enabled) => chrome.action.setBadgeText({ text: enabled ? "" : "off" });

chrome.storage.local.get({ enabled: true }, ({ enabled }) => render(enabled));

chrome.action.onClicked.addListener(async () => {
  const { enabled } = await chrome.storage.local.get({ enabled: true });
  await chrome.storage.local.set({ enabled: !enabled });
  render(!enabled);
});
