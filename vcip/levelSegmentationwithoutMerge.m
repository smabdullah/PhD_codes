function [V, nextpos] = levelSegmentationwithoutMerge(V,a,b,nextpos)
if V(a).level == V(b).level
    V(nextpos).maxcost = V(a).maxcost;
    V(nextpos).level = V(a).level + 1;
    V(nextpos).size = V(a).size;
    V(nextpos).p = nextpos;
    V(nextpos).list = V(a).list;
    V(nextpos).KNN = V(a).KNN;
    V(nextpos).colour = V(a).colour;
    V(nextpos).colourlab = V(a).colourlab;
    V(a).p = nextpos;
    nextpos = nextpos + 1;
    V(nextpos).maxcost = V(b).maxcost;
    V(nextpos).level = V(b).level + 1;
    V(nextpos).size = V(b).size;
    V(nextpos).p = nextpos;
    V(nextpos).list = V(b).list;
    V(nextpos).KNN = V(b).KNN;
    V(nextpos).colour = V(b).colour;
    V(nextpos).colourlab = V(b).colourlab;
    V(b).p = nextpos;
    nextpos = nextpos + 1;
elseif V(a).level < V(b).level
    V(a).p = nextpos;
    for i = V(a).level+1:V(b).level
        V(nextpos).maxcost = V(a).maxcost;
        V(nextpos).level = i;
        V(nextpos).size = V(a).size;
        V(nextpos).p = nextpos;
        V(nextpos).list = V(a).list;
        V(nextpos).KNN = V(a).KNN;
        V(nextpos).colour = V(a).colour;
        V(nextpos).colourlab = V(a).colourlab;
        nextpos = nextpos + 1;
    end
else
    V(b).p = nextpos;
    for i = V(b).level+1:V(a).level
        V(nextpos).maxcost = V(b).maxcost;
        V(nextpos).level = i;
        V(nextpos).size = V(b).size;
        V(nextpos).p = nextpos;
        V(nextpos).list = V(b).list;
        V(nextpos).KNN = V(b).KNN;
        V(nextpos).colour = V(b).colour;
        V(nextpos).colourlab = V(b).colourlab;
        nextpos = nextpos + 1;
    end
end
end