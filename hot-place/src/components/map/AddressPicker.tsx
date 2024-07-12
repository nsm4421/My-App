import ApiRoute from "@/util/constant/api_route";
import { RoadAdress } from "@/data/model/location_model";
import useGeoLocation from "@/util/hook/useGeoLocation";
import axios from "axios";
import { Dispatch, SetStateAction, useEffect, useState } from "react"

interface AddressPickerProps {
    label: string;
    address: RoadAdress | null;
    setAddress: Dispatch<SetStateAction<RoadAdress | null>>
}

// @TODO
// (ASIS) 현재 위치를 기준으로 도로명 주소를 검색하고, 유저가 주소를 선택할 수 있도록 함
// (ToBE) 유저가 주소를 검색할 수 있도록 함
export default function AddressPicker({ label, address, setAddress }: AddressPickerProps) {

    const [candidates, setCandidates] = useState<RoadAdress[]>([])
    const { isLoading, currentLocation, reFetch } = useGeoLocation()

    const getRoadAddress = async () => {
        setAddress(null)
        if (!currentLocation) {
            reFetch()
            return
        }
        await axios({
            ...ApiRoute.getRoadAddressFromCoordinate,
            params: {
                x: currentLocation.longitude,
                y: currentLocation.latitude
            }
        }).then(res => res.data).then(data => {
            console.log(data.message)
            setCandidates(data.addresses.map((adr: RoadAdress) => ({
                ...adr, ...currentLocation
            })))
        })
    }

    const handleSelectAddress = (selected: RoadAdress) => () => setAddress(selected)

    useEffect(() => {
        (async () => await getRoadAddress())()
    }, [currentLocation])

    return <div>

        <div className="justify-start flex items-center">
            <h3 className="text-xl font-semibold bg-slate-700 rounded-lg px-2 py-1 text-white inline mr-5">{label}</h3>
            {
                address && <span className="text-slate-800 hover:text-sky-700 text-xl font-bold cursor-pointer" onClick={getRoadAddress}>{address.address_name}</span>
            }
        </div>

        <ul className="my-3">
            {(!address && candidates) && candidates.map((candidate, index) => <li key={index}>
                <button onClick={handleSelectAddress(candidate)} className="bg-slate-500 text-white px-2 py-1 rounded-lg">
                    {candidate.address_name}
                </button>
            </li>)}
        </ul>

    </div>
}