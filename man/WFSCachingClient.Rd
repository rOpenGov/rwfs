% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/WFSClient.R
\name{WFSCachingClient}
\alias{WFSCachingClient}
\title{Downloads response from a WFS and parses the intermediate file}
\description{
Dispatches a WFS request, saves the response to a file and parses the file. The data can be converted
using ogr2ogr of RGDAL. Provides a caching mechanism for subsequent queries on the same data.
}
\seealso{
\code{\link{WFSRequest}}, \code{\link{WFSStreamingClient}}
}
\author{
Jussi Jousimo \email{jvj@iki.fi}
}
\section{Super class}{
\code{\link[rwfs:WFSClient]{rwfs::WFSClient}} -> \code{WFSCachingClient}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-saveGMLFile}{\code{WFSCachingClient$saveGMLFile()}}
\item \href{#method-loadGMLFile}{\code{WFSCachingClient$loadGMLFile()}}
\item \href{#method-listLayers}{\code{WFSCachingClient$listLayers()}}
\item \href{#method-getLayer}{\code{WFSCachingClient$getLayer()}}
\item \href{#method-clone}{\code{WFSCachingClient$clone()}}
}
}
\if{html}{
\out{<details open ><summary>Inherited methods</summary>}
\itemize{
\item \out{<span class="pkg-link" data-pkg="rwfs" data-topic="WFSClient" data-id="getRaster">}\href{../../rwfs/html/WFSClient.html#method-getRaster}{\code{rwfs::WFSClient$getRaster()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="rwfs" data-topic="WFSClient" data-id="initialize">}\href{../../rwfs/html/WFSClient.html#method-initialize}{\code{rwfs::WFSClient$initialize()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="rwfs" data-topic="WFSClient" data-id="setRequest">}\href{../../rwfs/html/WFSClient.html#method-setRequest}{\code{rwfs::WFSClient$setRequest()}}\out{</span>}
}
\out{</details>}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-saveGMLFile"></a>}}
\if{latex}{\out{\hypertarget{method-saveGMLFile}{}}}
\subsection{Method \code{saveGMLFile()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{WFSCachingClient$saveGMLFile(destFile)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-loadGMLFile"></a>}}
\if{latex}{\out{\hypertarget{method-loadGMLFile}{}}}
\subsection{Method \code{loadGMLFile()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{WFSCachingClient$loadGMLFile(fromFile)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-listLayers"></a>}}
\if{latex}{\out{\hypertarget{method-listLayers}{}}}
\subsection{Method \code{listLayers()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{WFSCachingClient$listLayers()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-getLayer"></a>}}
\if{latex}{\out{\hypertarget{method-getLayer}{}}}
\subsection{Method \code{getLayer()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{WFSCachingClient$getLayer(layer, ...)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-clone"></a>}}
\if{latex}{\out{\hypertarget{method-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{WFSCachingClient$clone(deep = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{deep}}{Whether to make a deep clone.}
}
\if{html}{\out{</div>}}
}
}
}
