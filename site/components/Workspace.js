import { useRouter } from 'next/router'

function Workspace({ Component, pageProps, workspace }) {
    const router = useRouter()

    const viewexample = (workspace) => {
        router.push({
            pathname: '/new/[workspace]',
            query: { workspace: btoa(workspace.friendly_name)}
        })
    }

    return (
        <div onClick={() => viewexample(workspace)} className="w-[280px] h-[100px] transition-all relative cursor-pointer group flex p-3 items-center justify-center bg-slate-100/90 shadow rounded hover:shadow-xl hover:bg-gradient-to-r hover:from-[#162d48] hover:to-[#2980b9] hover:text-white">
            <div className="w-full h-full">
                <div className="show-grid flex h-full items-center">
                    <div className="kasmcard-img flex h-full mx-3 items-center justify-center">
                        <img className="w-[64px] h-[64px] rounded object-contain" src={`${router.basePath}/icons/${workspace.image_src}`} />
                    </div>
                    <div className="kasmcard-detail settingPad">
                        <h5 className="text-base">{ workspace.friendly_name }</h5>
                        <p className="text-xs opacity-50">{ workspace.categories && workspace.categories[0] || 'Unknown' }</p>
                    </div>
                </div>
            </div>
        </div>
    )
}

export default Workspace
