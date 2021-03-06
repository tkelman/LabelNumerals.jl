module LabelNumerals

import Base: ==, isless, <, >, <=, +, -, max, min,
             convert, promote_rule, print, show, string, hash, parse

include("LabelNumeral.jl")
include("AlphaNumeral.jl")
include("ExtNumerals.jl")
include("LookupNumeral.jl")
include("AlphaNumNumeral.jl")


export LabelNumeral, findLabels,
       @an_str, AlphaNumeral,
       @ln_str, LookupNumeral, registerLookupNumerals,
       @ann_str, AlphaNumNumeral

allNumerals = [AlphaNumeral, RomanNumeral, Int, LookupNumeral, AlphaNumNumeral]

function findLabels(str::String, types::Vector{DataType} = allNumerals; pfxList=Vector{String}=[""])
    arr::Vector{Tuple{LabelNumeral,Type}} = Vector{Tuple{LabelNumeral,Type}}()
    for pfx in pfxList
        if(startswith(str, pfx))
            tstr = str[length(pfx)+1:end]
            for T in types
                try
                    ln = LabelNumeral(T, tstr; prefix=pfx)
                    push!(arr, (ln, T))
                catch
                end
            end
        end
    end
    return arr
end

end # module
